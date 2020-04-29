class HeadersSet

  def initialize(headers = [])
    @headers = headers
  end

  def numerated
    @headers.each do |header|
      numerated_headers << calculate_numeration(header)
    end

    numerated_headers
  end

  private

  def numerated_headers
    @numerated_headers ||= []
  end

  def calculate_numeration(header)
    previous_header = numerated_headers.last
    header_level = header[:heading_level].to_i + 1
    header_numeration = []

    if previous_header.nil?
      header_level.times { header_numeration << '1' }
    else
      previous_header_numeration = previous_header[:numeration].gsub('.', '').chars
      level_difference = header_level - previous_header_numeration.length

      if level_difference.zero?
        last_number = (previous_header_numeration.pop.to_i + 1).to_s
        previous_header_numeration << last_number

        header_numeration = previous_header_numeration
      elsif level_difference.positive?
        level_difference.times { previous_header_numeration << '1' }

        header_numeration = previous_header_numeration
      else
        leveled_numeration = previous_header_numeration.first(header_level)
        last_number = (leveled_numeration.pop.to_i + 1).to_s
        leveled_numeration << last_number

        header_numeration = leveled_numeration
      end
    end

    header_numeration_string = header_numeration.join('.')

    if header_numeration.length == 1
      header.merge(numeration: header_numeration_string + '.')
    else
      header.merge(numeration: header_numeration_string)
    end
  end
end
