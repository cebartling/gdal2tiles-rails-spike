class GenerateMosaicTilesJob < ApplicationJob
  queue_as :default

  def perform()
    puts "START: GenerateMosaicTilesJob.perform"
    input_file = Rails.root.join('data/input/sample-ndvi.tif')
    output_dir = Rails.root.join("data/output/#{Time.now.to_i}")
    command = 'python gdal2tiles.py --profile=mercator -z 18-20 --srcnodata=0'

    Open3.popen3("#{command} #{input_file} #{output_dir}") { |stdin, stdout, stderr, wait_thr|
      pid = wait_thr.pid # pid of the started process.
      exit_status = wait_thr.value # Process::Status object returned.
      puts "Process #{pid} exited with a status of #{exit_status}"
    }
    puts "END: GenerateMosaicTilesJob.perform"
  end
end
