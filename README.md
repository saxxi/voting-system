# README

# Installation

Requirements: postgres & redis

$ rails db:create db:migrate db:seed
$ rake import:voting docs/votes.txt
$ foreman start

# Implementation details

## Backend

Classic models in activerecord in postgres.

I added redis support as it was useful for both importing large amount of jobs and as a in-memory cache.

One of the requirements was in fact to check the integrity of the database so you can now save:
- `KeyValStore.save :campaigns, 'mycampaign', '3321'` maybe even trim `:campaigns` to `:c` to save space

Another benefit of using Redis store is to avoid the complexity of the query around `Candidate.votes_for_campaign(id)`.

My idea is to let `Redis` handle `INCR` counts to stats columns and use the SQL version as backup only in case Redis is down.

Jobs:

- I was thinking of saving `InvalidVotes` in case the parser had a massive failure and avoid sidekiq's retriable as often is not the server failing but wrong data format as input
- They could be batched instead of importing each line (need to see the performance benefits)

## Front end

- Simplest possible solution due to timing: classic rails with turbolinks
- Rails 5 nowadays ships with react/angular/vue, given more time or complexity of the requirements I'd opt for one of these solutions
