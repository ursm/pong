module Litefs
  module_function

  def primary?
    !File.exist?("/litefs/.primary")
  end
end
