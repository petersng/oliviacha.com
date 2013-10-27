require "vimeo"
require "uri"
require "json"

module Jekyll

    class ReelsPage < Page
        def initialize(site, base, dir, name, sections)
            super(site, base, dir, name)
            @sections = sections
            self.data['sections'] = sections
        end
    end


    class ReelsGenerator < Generator
        def generate(site)
            vimeo = get_vimeo_session
            sections = read_links_section_file(vimeo)
            site.pages << ReelsPage.new(site, site.source, 'reels', 'index.html', sections)
        end
        def get_vimeo_keys()
            file = File.open('vimeo_keys.txt')
            consumer_key = file.gets()
            consumer_secret = file.gets()
            access_token = file.gets()
            access_token_secret = file.gets()
            {
                "consumer_key" => consumer_key.strip!,
                "consumer_secret" => consumer_secret.strip!,
                "access_token" => access_token.strip!,
                "access_token_secret" => access_token_secret.strip!
            }
        end
        def get_vimeo_session()
            keys = get_vimeo_keys
            Vimeo::Advanced::Video.new(keys["consumer_key"],
                keys["consumer_secret"],
                :token => keys["access_token"],
                :secret => keys["access_token_secret"])
        end
        def strip_id_from_vimeo_link(link)
            parsed = URI(link)
            path = parsed.path
            path.split("/")[1].strip
        end
        def get_vimeo_video_info(vimeo, video_id)
            data = vimeo.get_info(video_id)
            data['video'][0]
        end
        def get_vimeo_video_thumbnail(video_data, width, height)
            thumbnails = video_data['thumbnails']['thumbnail']
            thumbnails.each do |thumb|
                if width > 0 and height > 0
                    if thumb['width'].to_i == width and thumb['height'].to_i == height
                        return thumb['_content']
                    end
                end
            end
            return ''
        end
        def read_links_section_file(vimeo)
            sections_links = []
            section = nil
            position = 0
            File.open('vimeo_links.txt').each_line do |line|
                line.rstrip!
                # Check for comments and blank lines.
                if line.start_with?('#') or line == ''
                    next
                # Check for section delineater.
                elsif line.start_with?('>>')
                    if section != nil
                        sections_links.push(section)
                    end
                    section_name = line.sub('>>', '')
                    section = {
                        'name' => section_name,
                        'links' => []
                    }
                    position = 1
                # Check to see if it is a link line.
                elsif line.start_with?('http')
                    link = line
                    video_id = strip_id_from_vimeo_link(link)
                    video_data = get_vimeo_video_info(vimeo, video_id)
                    section['links'].push({
                        'text' => '',
                        'video' => {
                            'url' => link,
                            'id' => video_id,
                            'position' => position,
                            'title' => video_data['title'],
                            'thumbnail' => get_vimeo_video_thumbnail(
                                video_data, 200, 150)
                        }
                    })
                    position = position + 1
                # Check to see if it just text
                else
                    section['links'].push({
                        'text' => line,
                        'video' => nil
                    })
                end
            end
            sections_links.push(section)
            sections_links
        end
    end
end
