alias be='bundle exec'
alias zc='zeus console'
alias zs='zeus server'
alias z='zeus start'
alias migrate='be rake db:migrate && be rake parallel:prepare'
alias populate='be rake db:reset && be rake db:migrate && be rake db:populate && rake parallel:prepare'
alias devlog='tail -f log/development.log'
alias testlog='tail -f log/test.log'
alias prodlog='tail -f log/production.log'
alias -g RET='RAILS_ENV=test'
alias -g REP='RAILS_ENV=production'
alias -g RED='RAILS_ENV=development'

function remote_console() {
  /usr/bin/env ssh $1 "( cd $2 && ruby script/console production )"
}
