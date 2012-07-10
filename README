# ListenUP

ListenUP is a SaaS web application to create and manage surveys. It was created
for the psychology students at John Brown University to use during a senior
seminar class on data collection.

## Design Challenges

The old system for sending surveys would have students crafting an email with
questions to send to their intended recipient. These had very low response
rates, as the non-psych students on campus would be deluged with these emails
at the end of every semester, along with the subsequent begging for responses.
These were solved by letting students write an introduction to their survey,
and then send it up to three times.

## The Good Parts

Here are some of the best portions of the codebase:

 - "app/controllers/surveys_controller.rb": Especially `#export`, which
   downloads a report as a CSV that identifies itself as an excel spreadsheet
   (a requirement of the department.)
 - "app/helpers/surveys_helper.rb": Transforms database records into answerable
   survey fields.

## Changes I'd make

Here's a list of some changes I'd make, knowing what I know now.

### MongoDB

The current state of the Survey model (and associated Question, Answer,
Recipient, and Response models) is a bit messy. I'd reimplement this to use
MongoDB, as it would be a pretty perfect way to store irregularly shaped
documents. For instance, a Response could look something like this:

    {
        "_id": ObjectID(...),
        "survey": ObjectID(...),
        "recipient": {"email": "email@email.com", "id": ObjectID(...)},
        "questions": {
            "How many pencils do you own?": 5
        }
    }

### Smaller changes

 - I'd use cancan or something similar to implement permissions - the existing
   code checks in multiple places and isn't very DRY.
 - Email should be sent asynchronously, especially bulkier mailings like these.
 - Better market research - looking back, it would have been easy to market
   this as a product to undergraduate psycology programs. They don't have a lot
   of good options when it comes to software (as of two years ago.)
 - Use a good JS library like Knockout or Ember to create a better
   user-experience when creating surveys.
