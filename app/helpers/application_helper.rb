module ApplicationHelper
def default_meta_tags
    {
      site: 'Gift Compass',
      reverse: true,
      charset: 'utf-8',
      description: 'Gift Compassはあなたのギフト選びをサポートします。',
      keywords: 'Gift, Compass, ギフト, プレゼント, 欲しいもの',
      canonical: request.original_url,
      separator: '☆',
      icon: [
        { href: image_url('app_icon.png') }
      ],
      # Twitter Card
      twitter: {
        card: 'summary',
        title: 'Gift Compass',
        description: 'Gift Compassはあなたのギフト選びをサポートします。',
        image: image_url('summary_icon.png'),
      }
    }
  end
end
