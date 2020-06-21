def palindrom_checker(st):

    po_pal = ''
    
    for i in st:
        po_pal = i + po_pal
    
    if po_pal == st:
        return('{} is palindrom!'.format(st))
    else:
        return('{} is not palindrom!'.format(st))
    
print(palindrom_checker('tenet'))
