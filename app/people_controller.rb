class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
  end


   def people_information
       newhash = Hash.new(0)
       text = [['people_by_dollar.txt','$'], ['people_by_percent.txt', '%']]
       i = 0
       text.each do |file_data|
           File.readlines("/spec/fixtures/#{file_data[0]}").drop(1).each do |line|
              hash = hash_formation(line, file_data[1])
              newhash.merge!({i => hash})
              i += 1
            end
      end
      newhash
  end

  private

  def sort_by_first_name
      peoples_information.sort_by{|k,v|  v[:first_name].strip }
  end

  def person_information(data, formatter)
      hash = {}
      hash[:first_name], hash[:city], hash[:birthdate] = data.split(formatter) if formatter == "%"
      hash[:city], hash[:birthdate], hash[:last_name], hash[:first_name] = data.split(formatter) if formatter == "$"
      hash
  end

  attr_reader :params
end
