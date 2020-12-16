# README

## Ruby on Rails Test Task - November 2020

### Background

Our company is currently working on a ticket-selling platform alongside an offshore team.
We were asked to create two services for ticket reserve and payment (see High-level features).
We don't know yet how other parts of the application looks like so we need to keep ourselves as versatile as possible (we agreed that this part will be written in Ruby). In order to do this please keep the number of dependencies as low as possible.While completing the test tasks please try to put yourself in the mind of the user(developer) as much as possible. It's very important to think of all the possible edge cases you can.

### High-level features
- Reserve ticket
- Show list of reserved tickets
- Pay for ticket

### Feature requirements

1. Reserve ticket
Each ticket has a selling option defined:
even - we can only buy tickets in quantity that is even
all together - we can only buy all the tickets at once
avoid one - we can only buy tickets in a quantity that will not leave only 1 ticket available Reservation is valid for 15 minutes, after that it is released.
2. Pay for ticket
. For the sake of simplicity we operate only on the EUR currency. Feel free to use the provided adapter.
3. Fetch list of reserved tickets
List should contain all details regarding reservations which might be useful for potential client.

### Technical requirements
- Tests should cover the happy path and edge cases you thought of.
Additional comments
- We really don't want to push you in any certain direction, but if you've made certain assumptions about how it should work with frontend then please let us know.
