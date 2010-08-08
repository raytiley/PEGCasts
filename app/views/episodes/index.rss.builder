xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Pegcasts.org - Episodes"
    xml.description "PEGCasts.org provides video tutorials aimed at Public, Educational, and Goverment Channels"
    xml.link formatted_episode_url(:rss)
    
    for episode in @episodes
      xml.item do
        xml.title episode.title
        xml.description episode.description
        xml.pubDate episode.created_at.to_s(:rfc822)
        xml.link episode_url(episode)
        xml.guid episode_url(episode)
      end
    end
  end
end