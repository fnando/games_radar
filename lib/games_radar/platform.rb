module GamesRadar
  class Platform
    PLATFORMS = {
      "1"                      => ["XBox", :xbox],
      "2"                      => ["PlayStation 2", :ps2],
      "3"                      => ["Game Boy", :gameboy],
      "4"                      => ["PC", :pc],
      "5"                      => ["PlayStation 3", :ps3],
      "6"                      => ["PSP", :psp],
      "7"                      => ["XBox 360", :xbox360],
      "8"                      => ["GameCube", :gc],
      "9"                      => ["Nintendo DS", :ds],
      "11"                     => ["Wii", :wii],
      "12"                     => ["Nintendo", :nes],
      "13"                     => ["Super Nintendo", :snes],
      "14"                     => ["Genesis", :genesis],
      "15"                     => ["Saturn", :saturn],
      "2005120714112598110961" => ["Game Boy Advanced", :gba],
      "2005120714112685461425" => ["PlayStation", :ps1],
      "2005120714112722229003" => ["Nintendo 64", :n64],
      "2005120714112823431396" => ["Dreamcast", :dc]
    }

    # The platform id
    attr_reader :id

    # The platform name
    attr_reader :name

    # The platform code
    attr_reader :code

    # Set up platform attributes based on the specified id.
    # The available platforms can be found on the GamesRadar::Platform::PLATFORMS constant.
    def initialize(id)
      @id = id.to_s
      raise GamesRadar::UnknownPlatformError unless PLATFORMS[@id]
      @name, @code = PLATFORMS[@id]
    end
  end
end
