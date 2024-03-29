# -*- encoding: utf-8 -*- 

module Ukrainian
  # Ukrainian transliteration 
  #
  
  module Transliteration
    extend self

    # Transliteration heavily based on rutils gem by Julian "julik" Tarkhanov and Co.
    # <http://rutils.rubyforge.org/>
    # Cleaned up and optimized.

    LOWER_SINGLE = {
      "і"=>"i","ґ"=>"g","ё"=>"yo","№"=>"#","є"=>"ie",
      "ї"=>"i","а"=>"a","б"=>"b",
      "в"=>"v","г"=>"h","д"=>"d","е"=>"e","ж"=>"zh",
      "з"=>"z","и"=>"y","й"=>"i","к"=>"k","л"=>"l",
      "м"=>"m","н"=>"n","о"=>"o","п"=>"p","р"=>"r",
      "с"=>"s","т"=>"t","у"=>"u","ф"=>"f","х"=>"kh",
      "ц"=>"ts","ч"=>"ch","ш"=>"sh","щ"=>"sch","ъ"=>"'",
      "ы"=>"y","ь"=>"‘","э"=>"e","ю"=>"iu","я"=>"ia",
    }

    LOWER_MULTI = {
      "зг" => 'gh'
    }

    UPPER_SINGLE = {
      "Ґ"=>"G","Ё"=>"YO","Є"=>"IE","Ї"=>"I","І"=>"I",
      "А"=>"A","Б"=>"B","В"=>"V","Г"=>"H",
      "Д"=>"D","Е"=>"E","Ж"=>"ZH","З"=>"Z","И"=>"Y",
      "Й"=>"I","К"=>"K","Л"=>"L","М"=>"M","Н"=>"N",
      "О"=>"O","П"=>"P","Р"=>"R","С"=>"S","Т"=>"T",
      "У"=>"U","Ф"=>"F","Х"=>"KH","Ц"=>"TS","Ч"=>"CH",
      "Ш"=>"SH","Щ"=>"SCH","Ъ"=>"'","Ы"=>"Y","Ь"=>"‘",
      "Э"=>"E","Ю"=>"IU","Я"=>"IA",
    }
    UPPER_MULTI = {
      "ЗГ" => 'GH'
    }
    
    WORD_BEGINNINGS = {
      'Є' => "YE",
      'Ї' => "YI",
      'Й' => "Y",
      'Ю' => "YU",
      'Я' => "YA",
    }

    LOWER = (LOWER_SINGLE.merge(LOWER_MULTI)).freeze
    UPPER = (UPPER_SINGLE.merge(UPPER_MULTI)).freeze
    MULTI_KEYS = (LOWER_MULTI.merge(UPPER_MULTI)).keys.sort_by {|s| s.length}.reverse.freeze
    
    POSSIBLE_SKIPPING = ['ь', 'Ь', 'ъ', 'Ъ']

    # Transliterate a string with russian characters
    #
    def transliterate(str, skip = false)
      str ||= ''
      chars = str.scan(%r{^#{WORD_BEGINNINGS.keys.join '|^'}|#{MULTI_KEYS.join '|'}|\w|.})

      result = ""

      chars.each_with_index do |char, index|
        next if POSSIBLE_SKIPPING.include? char

        if WORD_BEGINNINGS.has_key?(char) && index == 0
          result << WORD_BEGINNINGS[char].downcase.capitalize
        elsif UPPER.has_key?(char) && LOWER.has_key?(chars[index+1])
          # combined case
          result << UPPER[char].downcase.capitalize
        elsif UPPER.has_key?(char)
          result << UPPER[char]
        elsif LOWER.has_key?(char)
          result << LOWER[char]
        else
          result << char
        end
      end

      result
    end
    
  end
end