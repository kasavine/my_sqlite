require 'readline'

#
# Smarter Readline to prevent empty and dups
#   1. Read a line and append to history
#   2. Quick Break on nil
#   3. Remove from history if empty or dup
#
def readline_with_hist_management
    line = Readline.readline('> ', true)
    return nil if line.nil?
    if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
        Readline::HISTORY.pop
    end
    line
end

# Debug
while line = readline_with_hist_management
    p line
    p Readline::HISTORY.to_a
end