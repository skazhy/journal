# encoding: UTF-8

module Jekyll
  class Post
    ATTRIBUTES_FOR_LIQUID.push('localdate')
    MONTHS = [
      '',
      'janvārī',
      'februārī',
      'martā',
      'aprīlī',
      'maijā',
      'jūnijā',
      'jūlijā',
      'augustā',
      'septembrī',
      'oktobrī',
      'novembrī',
      'decembrī',
    ]

    def localdate
      d = self.data['published']
      "#{d.year}. gada #{d.day}. #{MONTHS[d.month]}"
    end
  end
end
