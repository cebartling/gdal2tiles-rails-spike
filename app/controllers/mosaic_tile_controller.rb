class MosaicTileController < ApplicationController
  def create
    GenerateMosaicTilesJob.perform_later()
  end
end
