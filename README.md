# HW07: Event Manager (Part 1) & HW08: Event Manager (Part 2)

## Code Attribution

This homework includes code from and based on Prof Tuck's in-class PhotoBlog example.

## Design Decisions

- Anyone can create a new event, but they can only view events they've created
  or been invited to
- Date picker must take time in 24-hour format but it will convert it to am/pm 
  format to display
- Owner of event can only add invitees one at a time
- Only the owner of the event can invite people
- Both emails in login and registration are case insensitive
- Two people can't have the same email 
- You are automatically prompted with text to login or register 
- If a user clicks their name at the top, they can edit their information 
