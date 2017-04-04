# Optimizing performance

// TO DO: check code examples work

## About performance

Apple event IPC is subject to a number of potential performance bottlenecks:

* Sending Apple events is more expensive than calling local functions.

* There may be significant overheads in how applications resolve individual object references.

* Packing and unpacking large and/or complex values (e.g. a long list of object specifiers) can take an appreciable amount of time.

[TO DO: include note that AEs were originally introduced in System 7, which had very high process switching costs, so were designed to compensate for that]

Fortunately, it's often possible to minimise performance overheads by using fewer commands to do more work. Let's consider a typical example: obtaining the name of every person in `Contacts.app` who has a particular email address. There are several possible solutions to this, each with very different performance characteristics:


## The iterative OO-style approach

While iterating over application objects and manipulating each in turn is a common technique, it's also the slowest by far:

    // `aeglue Contacts.app`
    let contacts = Contacts()

    let desiredEmail = "sam.brown@example.com"

    var foundNames = [String]()
    for person in contacts.people.get() as [CONItem] {
      for email in people.emails.get() as [CONItem] {
          if email.value.get() == desiredEmail {
              foundNames += person.name.get()
          }
      }
    }
    print(foundNames)

The above code sends one Apple event to get a list of references to all people, then one Apple event for each person to get a list of references to their emails, then one Apple event for each of those emails. Thus the time taken increases directly in proportion to the number of people in Contacts. If there's hundreds of people to search, that's hundreds of Apple events to be built, sent and individually resolved, and performance suffers as a result.

The solution, where possible, is to use fewer, more sophisticated commands to do the same job.


## The smart query-oriented approach

While there are some situations where iterating over and manipulating each application object individually is the only option (for example, when setting a property in each object to a different value), in this case there is plenty of room for improvement. Depending on how well an application implements its AEOM support, it's possible to construct queries that identify more than one application object at a time, allowing a single command to manipulate multiple objects in a single operation.

In this case, the entire search can be performed using a single complex query sent to Contacts via a single Apple event:

    let contacts = Contacts()

    let desiredEmail = "sam.brown@example.com"

    let foundNames = contacts.people[CONIts.emails.value.contains(desiredEmail)].name.get() as [String]

    print(foundNames)

To explain:

* The query states: "Find the name of every person object that passes a specific test."

* The test is: "Does a given value, `"sam.brown@example.com"`, appear in a list that consists of the value of each email object contained by an individual person?"

* The command is: "Evaluate that query against the AEOM and get (return) the result, which is a list of zero or more strings: the names of the people matched by the query."



## The hybrid solution

While AEOM queries can be surprisingly powerful, there are still many problems too complex for the application to evaluate entirely by itself. For example, let's say that you want to obtain the name of every person who has an email addresses that uses a particular domain name. Unfortunately, this test is too complex to express as a single AEOM query; however, it can still be solved reasonably efficiently by obtaining all the data from the application up-front and processing it locally. For this we need: 1. the name of every person in the Contacts, and 2. each person's email addresses. Each request can be described in a single query, allowing all of the required data to be retrieved using just two `get` commands.

    let contacts = Contacts()

    let desiredDomain = "@example.com"

    // get each person's name
    let names = contacts.people.name.get() as [String]

    // get each person's email addresses
    let emailsByPerson = contacts.people.emails.value.get() as [[String]]

    var foundNames = [String]()
    for (name, emails) in zip(names, emailsByPerson) {
        for email in emails {
            if email.hasSuffix(desiredDomain) {
                foundNames.append(name)
                break
            }
        }
    }
    print(foundNames)

This solution isn't as fast as the pure-query approach, but is still far more efficient than iterating over and manipulating every person and email element one at a time.

