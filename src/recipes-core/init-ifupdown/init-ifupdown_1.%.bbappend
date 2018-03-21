FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

##
# Create an interface file with the correct configuration
##
python do_create_interfaces(){
    import re

    # Get path to current recipe
    rootBbclassAppend = d.getVar('THISDIR')+"/../../../../../src/recipes-core/init-ifupdown"

    # Select the referance interface depending on the type required
    referance = rootBbclassAppend + "/files/interfaces_reference_" + d.getVar('ETHERNET_TYPE')

    # Open the selected interface file and get the conent
    with open(referance, 'r') as instream:
        content = instream.read()

    # Replace placeholders in the content with local variables
    content=re.sub("\${(.*?)}", (lambda m: d.getVar(m.group(1))), content)

    # Create the new interface file
    with open(rootBbclassAppend + "/files/interfaces", 'w') as outstream:
        outstream.write(content)
}

# Run function before build to generate the interfaces file
addtask do_create_interfaces before do_build



