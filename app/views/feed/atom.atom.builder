atom_feed do |feed|
  feed.title("LMR News")
  feed.updated(@post.try(:first).try(:created_at))
  feed.author do |fa|
    fa.email 's@softserveinc.com'
  end

  @posts.each do |post|
    feed.entry(post, :url => news_post_path(post)) do |entry|
      entry.title(post.title)
      entry.url(news_post_path(post))
      entry.content post.content, :type => 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(post.created_at.try(:strftime, "%Y-%m-%dT%H:%M:%SZ")) 
      
      entry.author do |author|
        author.name entry.created_by
      end
    end
  end
end

