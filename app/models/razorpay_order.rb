class RazorpayOrder < ApplicationRecord
	self.table_name = :razorpay_orders
	belongs_to :user
	enum status: {created: "created", failures: "failures", pending: "pending" }
end
