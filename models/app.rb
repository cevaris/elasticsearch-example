require 'active_support/all'

class App

  attr_accessor :id, :name, :access_token :created_at

  sample_tokens = [
    [id: 1, access_token: '4515246cc205364683adf0f217d91ec5', name: 'lorem ipsum dolor', 10.days.ago],
    [id: 2, access_token: '4515246cc205364683adf0f217d91ec5', name: 'vestibulum sit amet', 1.days.ago],
    [id: 3, access_token: '4515246cc205364683adf0f217d91ec5', name: 'accumsan tellus', 20.days.ago],
    [id: 4, access_token: '4515246cc205364683adf0f217d91ec5', name: 'vehicula consequat morbi', 30.days.ago],
    [id: 5, access_token: '4515246cc205364683adf0f217d91ec5', name: 'accumsan odio curabitur', 14.days.ago],
    [id: 6, access_token: '4515246cc205364683adf0f217d91ec5', name: 'luctus et ultrices', 16.days.ago],
    [id: 7, access_token: '4515246cc205364683adf0f217d91ec5', name: 'lorem ipsum dolor', 12.days.ago],
    [id: 8, access_token: '4515246cc205364683adf0f217d91ec5', name: 'lorem ipsum dolor', 12.days.ago],
    [id: 9, access_token: '4515246cc205364683adf0f217d91ec5', name: 'lorem ipsum dolor', 19.days.ago],
    [id: 10, access_token: '4515246cc205364683adf0f217d91ec5', name: 'lorem ipsum dolor', 33.days.ago],
  ]

  def self.get_app()
    sample = sample_tokens.sample

    obj = App.new
    obj.id = 
    obj.name = 
    obj.access_token = 

    

  end
end