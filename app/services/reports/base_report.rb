class Reports::BaseReport
    def initialize(params = {})
      @params = params
    end
  
    def generate
      raise NotImplementedError, 'Subclasses must implement the generate method'
    end
  
    def format_data(data)
      data
    end
  end