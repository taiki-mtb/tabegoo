module StaticPagesHelper
	def random
    Restaurant.pluck(:id).sample
  end
end
