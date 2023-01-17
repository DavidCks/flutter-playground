# CJKI Dictionary Catalogue (Flutter)
---

### Extracting Data Structures
Passing individual values like `name` or `author` to child components whould make the code less maintainable as requirements in data might change, but passing a dynamic list of which you'd have to remember the keys or reference the json document adds needless overhead, so instead I defined a data structure appropriate for this test. 

### Extracting Styling
Mixing styling and logic is only a good idea if the logic depends on the styling or vice versa. This way specific styling can be edited fast and without much hassle.

### Extracting Error Messages
Handling errors directly in the main code make it less legible.

### Details Page
The details page is rendered based on a predefined data structure, which makes it accessible to any caller that has access to such a data structure.

### Naming
Classes with a `PageView` suffix are responsible for the actual page view, while the ones with just `Page` handle the logic and the appbar of that page so it is possible to understand what a class roughly does.

### Comments
Comments are used sparcely and mainly to summorize larger blocks of code, since the code is written in a readable and human-parsable way.

---
##### Estimated Time Spent
3 hours <span style="font-size: 80%">(which includes this write up)</span>