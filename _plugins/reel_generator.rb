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
            File.open('vimeo_keys.txt') do |line|

            end
        end
        def get_vimeo_session()
            Vimeo::Advanced::Video.new("7598b66411cf608028fa81754640d69a17f23bb2",
                "f050e42e8d1df675c99a704f3222452639ec4a0c",
                :token => '6c617d440d5dfea4d27e9c3a9ed6dfee',
                :secret => '98b0da9d928e35c4467a25959250dee8f7934850')
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
        def get_vimeo_video_thumbnail(vimeo, video_id, width, height)
            video_data = get_vimeo_video_info(vimeo, video_id)
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
                        'text' => '',
                        'links' => []
                    }
                    position = 1
                # Check to see if it is a link line.
                elsif line.start_with?('http')
                    link = line
                    video_id = strip_id_from_vimeo_link(link)
                    section['links'].push({
                        'url' => link,
                        'id' => video_id,
                        'position' => position,
                        'thumbnail' => get_vimeo_video_thumbnail(
                            vimeo, video_id, 200, 150)
                    })
                    position = position + 1
                # Check to see if it just text for that section
                else
                    section['text'] = line
                end
            end
            sections_links.push(section)
            sections_links
        end
    end
end
