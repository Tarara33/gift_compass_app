module ApplicationHelper
def default_meta_tags
    {
      site: 'Gift Conpass',
      reverse: true,
      charset: 'utf-8',
      description: 'Gift Conpassはあなたのギフト選びをサポートします。',
      keywords: 'Gift, Conpass, ギフト, プレゼント, 欲しいもの',
      canonical: request.original_url,
      separator: '☆',
      icon: [
        { href: image_url('app_icon.png') }
      ]
    }
  end
end
