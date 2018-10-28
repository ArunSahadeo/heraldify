module AdminHelpers
    def getHello
        return 'Hello world'
    end
    class App < Sinatra::Base
        helpers AdminHelpers
    end
end
