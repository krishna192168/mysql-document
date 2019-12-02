# mysql-document

### Synopsis
  In this application user can book ticket based on bus category.
### TNSTC ticket booking system
- Tables
  - tnstc_user
  - tnstc_bus_type
  - tnstc_bus
  - tnstc_city
  - book_ticket
  - user_vault
### Security
  - If user enter invalid seats, it will throw message like bus seats not available.
  - If user enter invalid amount it throw message like ticket booking is failed and then get rollbacked.
