Templater is a templating engine, similar to eRuby or Jade.

The template file will be in mostly-HTML but will contain some places to insert values from the object list. These places are denoted by the <* and *> symbols. For example, <* title *> indicates that we should substitute the value of the key title from the JSON data at that point in the template. (Spaces between the asterisks and the variable are optional.) <* course.name *> indicates that we should substitute in the name attribute of course in our data object. And looping constructs are also possible, with a <* EACH arrayName itemName *> ... <* ENDEACH *> construct.

It is runnable as a command-line command called templater, in the following format:

templater template.panoramatemplate data.json output.html
