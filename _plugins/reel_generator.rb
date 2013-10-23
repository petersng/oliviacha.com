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
            sections = [{
                'name' => 'tv',
                'links' => [
                    {
                        'id' => 76516796,
                        'position' => 1,
                        'thumbnail' => 'http://b.vimeocdn.com/ts/451/349/451349356_200.jpg'
                    },
                    {
                        'id' => 77002689,
                        'position' => 2,
                        'thumbnail' => 'http://b.vimeocdn.com/ts/452/046/452046229_200.jpg'
                    },
                    {
                        'id' => 77002689,
                        'position' => 3,
                        'thumbnail' => 'http://b.vimeocdn.com/ts/452/046/452046229_200.jpg'
                    },
                    {
                        'id' => 77002689,
                        'position' => 4,
                        'thumbnail' => 'http://b.vimeocdn.com/ts/452/046/452046229_200.jpg'
                    },
                    {
                        'id' => 77002689,
                        'position' => 5,
                        'thumbnail' => 'http://b.vimeocdn.com/ts/452/046/452046229_200.jpg'
                    }
                ]
            }]
            site.pages << ReelsPage.new(site, site.source, 'reels', 'index.html', sections)
        end
    end
end
