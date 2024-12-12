require 'httparty' 
class AiVirtualMannequinService
BASE_URL = "https://api.zyler.com/v1"
def initialize(user)
    @user = user
end

def create_zyler_user
    response = HTTParty.post("#{BASE_URL}/users",
    headers: {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
    },
    body: {
        email: @user.email,
        privacyPolicyConfirmed: true,
        partnerTermsConfirmed: true
    }.to_json
    )

    if response.code == 200
    parsed_response = response.parsed_response
    create_user(parsed_response)
    else
    error_details = JSON.parse(response.body)["status"]
    raise StandardError, error_details["errorMessage"]
    end
end

private

    def create_user(parsed_response)
        result = parsed_response["result"]

        ZylerUser.create!(
        account_id: @user.id,
        full_name: @user.full_name,
        email: result["email"],
        user_name: result["id"],
        password: result.dig("token", "code"),
        user_id: result["userId"],
        partner_terms_confirmed: result["partnerTermsConfirmed"] || true,
        privacy_policy_confirmed: result["privacyPolicyConfirmed"] || true
        )
    rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error("ZylerUser creation failed: #{e.message}")
        raise
    end
end
