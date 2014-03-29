
class Event
  
  attr_accessor :payload

  def self.save(payload)
    $esc.index(index: 'es', type: 'events', id: payload[:id], body: payload)
  end

end