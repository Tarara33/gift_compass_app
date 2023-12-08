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
        card: 'summary_large_image',
        title: 'Gift Compass',
        description: 'Gift Compassはあなたのギフト選びをサポートします。',
        image: image_url('/app/assets/images/logo.jpg'),
      }
    }
  end
end
