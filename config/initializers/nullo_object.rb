
# this extends the Object to include the method nullo

class Object
  def nullo
    NulloObject::Nullo.new self
  end
end