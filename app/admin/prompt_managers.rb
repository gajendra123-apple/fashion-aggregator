# require 'prompt_service'
require "csv"

ActiveAdmin.register PromptManager, as: "PromptManager" do
  VERSION = "LLM Model"
  menu label: "Prompt Manager"

  permit_params :gpt_version, :prefix, :question, :prompt_template, :answer, prompt_review_attributes: [:review, :comment, :scoring]

  index title: "Prompt Manager" do
    selectable_column
    id_column
    column :question
    column :prefix
    column :answer
    column :gpt_version do |pm|
      pm.gpt_version&.titleize
    end
    column :prompt_template
    column :created_at
    actions
  end

  config.clear_action_items!

  action_item :only => :index do
    link_to 'New Prompt', new_admin_prompt_manager_path
  end

  form do |f|
    f.inputs do
      if f.object.new_record?
        f.input :gpt_version, label: VERSION,as: :select, include_blank: "Select LLM Version", collection: PromptManager.gpt_versions
        f.input :prefix
        f.input :question
        f.input :prompt_template, label: "Suffix"

        f.actions do
          div class: "preview-button-div" do
            f.submit 'Preview', name: 'preview', class: 'preview-button'
          end
        end
      else
        f.input :gpt_version, label: VERSION, input_html: { disabled: true }
        f.input :prefix, label: "Prefix", input_html: { disabled: true }
        f.input :question, input_html: { disabled: true }
        f.input :prompt_template, label: "Suffix", input_html: { disabled: true }
        f.input :answer, input_html: { disabled: true }
      end
    end

    if !f.object.new_record? && f.object.answer.present?
      f.inputs "Review" do
        f.object.build_prompt_review unless f.object.prompt_review
        f.semantic_fields_for :prompt_review do |r|
          r.input :review, as: :select, collection: PromptReview.reviews.keys
          r.input :comment
          r.input :scoring, as: :select, collection: (1..10)
        end
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row VERSION do |pm|
        pm.gpt_version&.titleize
      end
      row :prefix
      row :question
      row :prompt_template, label: "Suffix"
      row :answer
      row :created_at
    end

    panel "Review" do
      if resource.prompt_review.present?
        attributes_table_for resource.prompt_review do
          row :review
          row :comment
          row :scoring
        end
      else
        div do
          link_to "Add Review", edit_admin_prompt_manager_path(resource)
        end
      end
    end
  end


  member_action :export_csv, method: :get do
    @prompt_manager = PromptManager.find(params[:id])
    
    respond_to do |format|
      format.csv { send_data to_csv(@prompt_manager), filename: "prompt_manager-#{@prompt_manager.id}.csv" }
      format.html { redirect_to admin_prompt_manager_path(@prompt_manager), notice: "CSV export requested." }
    end
  end

  action_item :export_csv, only: :show do
   link_to 'Export to CSV', export_csv_admin_prompt_manager_path(prompt_manager, format: :csv), method: :get
  end

  # generate CSV data
  controller do
    def to_csv(prompt_manager)
      CSV.generate(headers: true) do |csv|
        csv << ['Version', 'Prefix', 'Question', 'Suffix', 'Answer', 'Created At']

        csv << [
          prompt_manager.gpt_version&.titleize,
          prompt_manager.prefix,
          prompt_manager.question,
          prompt_manager.prompt_template,
          prompt_manager.answer,
          prompt_manager.created_at
        ]
      end
    end
  end


  controller do
    def create
      if params[:preview]
        handle_preview
      else
        handle_creation
      end
    end

    private

    def handle_preview
      @prompt_manager = PromptManager.new(prompt_params)
      if prompt_params["gpt_version"].present?
        @preview_content = generate_preview(@prompt_manager)
        render 'admin/prompt_managers/preview'
      else
        redirect_to new_admin_prompt_manager_path, alert: "Please select LLM version."
      end
    end

    def handle_creation
      gpt_version = params[:prompt_manager][:gpt_version]
      messages = [
        { role: 'system', content: params[:prompt_manager][:prompt_template] },
        { role: 'user', content: params[:prompt_manager][:question] }
      ]
      response_content = PromptService.response_chat(messages, gpt_version)

      if response_content.present?
        byebug
        # prompt_params = params.require(prompt_manager).permit(:gpt_version, :prefix, :question, :prompt_template)
        prompt = PromptManager.new(prompt_params)
        prompt.answer = response_content

        if prompt.save
          redirect_to edit_admin_prompt_manager_path(prompt), notice: "Answer generated successfully. Now you can add a review."
        else
          redirect_to new_admin_prompt_manager_path, alert: "Failed to save the prompt."
        end
      else
        redirect_to new_admin_prompt_manager_path, alert: "Failed to get a response from GPT."
      end
    end

    def generate_preview(prompt_manager)
      "LLM Model: #{prompt_manager.gpt_version.titleize}\n\n" \
      "Prefix: #{prompt_manager.prefix}\n\n" \
      "Question: #{prompt_manager.question}\n\n" \
      "Suffix: #{prompt_manager.prompt_template}"
    end

    def prompt_params
      params.require(:prompt_manager).permit(:gpt_version, :prefix, :question, :prompt_template)
    end
  end
end

