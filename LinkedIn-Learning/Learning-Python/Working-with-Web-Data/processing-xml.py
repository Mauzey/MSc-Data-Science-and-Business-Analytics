# import
import xml.dom.minidom


def main():
    # use the parse() function to load and parse an xml file
    doc = xml.dom.minidom.parse("samplexml.xml")
    
    # print out the document node and the name of the first child tag
    print(doc.nodeName)
    print(doc.firstChild.tagName)
    
    # get a list of xml tags from the document and print each one
    skills = doc.getElementsByTagName("skill")
    print("\n%d skills: " % skills.length)
    for skill in skills:
        print(skill.getAttribute("name"))
    
    # create a new xml tag and add it to the document
    new_skill = doc.createElement("skill")
    new_skill.setAttribute("name", "jQuery")
    doc.firstChild.appendChild(new_skill)
    
    skills = doc.getElementsByTagName("skill")
    print("\n%d skills: " % skills.length)
    for skill in skills:
        print(skill.getAttribute("name"))


if __name__ == '__main__':
    main()
