
require 'readline'
# def readline_with_hist_management
#     line = Readline.readline('> ', true)
#     return nil if line.nil?
#     if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
#         Readline::HISTORY.pop
#     end
#     line
# end

# # Debug
# while line = readline_with_hist_management
#     p line
#     p Readline::HISTORY.to_a
# end

def cli
    puts "MySQLite version 0.3 2020-05-23"
    loop do
      buf = Readline.readline("my_sqlite_cli> ", true)
      if buf == "quit"
        break
      end
    #   request = request_parser(buf)
    #   result = run_request(request)
    #   if (request && request["select"] && result.kind_of?(Array))
        # hash_to_array(result).each {|row| puts row}
      end
    # end
  end
  
  cli()
