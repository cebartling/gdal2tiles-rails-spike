class MosaicTileController < ApplicationController
  def create
    GenerateMosaicTilesJob.perform_later(10)
  end
end
