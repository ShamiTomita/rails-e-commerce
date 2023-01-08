This applications is meant to showcase not only my web development fundamentals but also my ability to learn new technologies. Here I'm learning and utilizing the new feature of Rails 7, Hotwire and its two main components: Turbo and Stimulus.

Turbo helps to bring the Single Page Application feel to a project by intercepting requests and rendering only parts of the page.

Turbo Drive: accelerates links and form submissions by negating the need for full page reloads

Turbo Frames: decompose pages into independent contexts, which scope navigation and can be lazily loaded

Turbo Streams: deliver page changes over WebSocket SSE, or in response to form submissions using just HTML and CRUD like actions  


/////// 

Admin Dashboard: 
Have to figure out a way to easily create an admin, maybe through a mailer?

Admin Dashboard should have all the products, a list of users, a list of orders, and graphs for orders!

///////
Jan 8th
Where are? 
Well routes aren't very restful at least for checkouts so will brush up on routing first 
And From there, the current issues for this project are:
Fixing Routes for Checkout, will probably involve/include changes to the way orders, carts, line items, and order items interact 
Once that is straightened out, testing will be a lot easier 
....
Ok so fixing routes was actually pretty easy and things seem more streamlined
 Next up I'd like to crack open the admin dashboard 
 so admins when they login should be sent to the admin dashboard first 
 the dashboard will need to be modular