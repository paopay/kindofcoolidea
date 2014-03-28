require 'open-uri'
require 'zlib'
require 'sqlite3'

#################################### CHANGE THESE IF NECESSARY #####################################

IMDB_LINK = 'ftp://ftp.fu-berlin.de/pub/misc/movies/database/movies.list.gz'
# the IMDB link from: ftp://ftp.fu-berlin.de/pub/misc/movies/database/

GZIPFILE  = 'imdb_raw_movie_list.gz'              # constant: the name of the downloaded gzip file
RAWFILE   = 'imdb_raw_movie.list'                 # constant: the name of the extracted gzip file
CLEANFILE = 'imdb_movies.txt'                     # constant: the final version of the information

DBNAME    = 'db/final_project_group4.db'          # constant: the database name

puts "file names established"

##################################### DEAL WITH EXISTING FILES #####################################

unless File.exists?(RAWFILE)                      # as long as we need the file
  imdb_raw = File.new(GZIPFILE, 'w')              # create a temp file to store the file
  puts "downloading gzip file with fresh data"
  open(IMDB_LINK) do |f|                          # open the link
    imdb_raw.print f.read                         # and put the downloaded content into temp file
  end
  puts "gzip file saved to disk"
  imdb_raw.close                                  # close the file

  Zlib::GzipReader.open(GZIPFILE) do |gz|         # then open the saved gzip file
    File.open(RAWFILE, 'w') do |g|                # create a file to store the content extracted
      IO.copy_stream(gz, g)                       # and then copy in the content
    end
  end

  puts "gzip file extracted into temp file"

  File.delete(GZIPFILE)                           # delete the gzip, leaving the extracted file
  puts "gzip file deleted"
end

########################################### PROCESS DATA ###########################################

moviedata = File.readlines(RAWFILE, encoding: "windows-1252:utf-8")   # read in the extracted file

puts "extracted file loaded"
                                                  # we need to figure out the actual movie data is
start_index = moviedata.index("="*11 + "\n") + 2  # the + 2 is to start 2 lines after the delimiter
end_index  = moviedata.rindex("-"*80 + "\n") - 1  # the -1 is to stop 1 line before the delimeter

puts "data start/end points found"

moviedata = moviedata[start_index..end_index]     # only keep the actual movie data

puts "fresh movie data extracted"

moviedata = moviedata.reject do |line|            # go through the movies data and
  line.include?('{')       ||                     # remove episodes
  line.include?(' (V)')   ||                      # remove videos
  line.include?(' (TV)')   ||                     # remove TV movies
  line.include?(' (VG)')   ||                     # remove video games
  /\-(\?{4}|\d\d\d\d)$/ =~ line                   # remove TV (has year range)
end

puts "TV episodes, TV movies, and video games removed"

moviedata = moviedata.map do |line|               # go through the data and
  line  = line.chomp                              # remove new line character at the end
  line  = line.sub(/\t+/, "|")                    # replace consecutive tabs with pipe
  line  = line.split("|")                         # split line into movie (year)|year

  movie   = line.first                            # store movie
  x = /(?<movie>.*) \(.*(\?{4}|\d\d\d\d).*\)/     # define pattern to separate movie from year
  movie   = x.match(movie)[:movie]                # clean movie

  year    = line.last                             # store year

  line  = [movie, year]                           # return an array of the clean movie information
end

puts "data cleaned"

######################################## WRITE DATA TO FILE ########################################

# puts "attempting to write data to file"

# if File.exists?(CLEANFILE)                        # if a previous version of the file exists
#   File.delete(CLEANFILE)                          # delete it to write a fresh copy
#   puts "old version of clean data deleted"
# end

# File.open(CLEANFILE, "w") do |f|                  # open up the final data File
#   moviedata.each do |movie|                       # and for each movie that we have cleaned
#     f.puts movie.join("|")                        # write it to the file as: movie|year
#   end
# end

# puts "SUCCESS! fresh clean data written to file: #{CLEANFILE}"

######################################### WRITE DATA TO DB #########################################

puts "attempting to write data to database"

db = SQLite3::Database.new(DBNAME)

db.execute("DROP TABLE IF EXISTS movies")

moviedata.each do |data|
  movie = data[0]
  year  = data[1]

  db.execute("INSERT INTO movies (title, year) VALUES (?, ?)", movie, year)
end

puts "SUCCESS! fresh clean data written to database: #{DBNAME}"

############################################# CLEANUP ##############################################

puts "cleaning up"

File.delete(RAWFILE)                              # now that all is done, delete the raw file

puts "temp file deleted"

puts "PROCESS COMPLETE!"