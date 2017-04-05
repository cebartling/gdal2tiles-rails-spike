class MosaicTileController < ApplicationController
  def create
    GenerateMosaicTilesJob.set(queue: :tile_generation).perform_later()
  end
end
