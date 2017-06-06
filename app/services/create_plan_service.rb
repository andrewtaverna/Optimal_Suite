class CreatePlanService
  def call
    p1 = Plan.where(name: 'Yearly').first_or_initialize do |p|
      p.amount = 36000
      p.interval = 'year'
      p.stripe_id = 'yearly'
    end
    p1.save!(:validate => false)
    p2 = Plan.where(name: 'Monthly').first_or_initialize do |p|
      p.amount = 3900
      p.interval = 'month'
      p.stripe_id = 'monthly'
    end
    p2.save!(:validate => false)
  end
end
