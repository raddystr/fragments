function turnObjectToJSONString(arr){
    let info = {};
    for (let obj of arr) {
        let input = obj.split(" -> ")
        let key = input[0];
        let value = input[1];
        if(!isNaN(value)){
            value = Number(value)
        }
        info[key]=value;
    }
    console.log(JSON.stringify(info));
}
turnObjectToJSONString([
    //example
    'name -> Angel',
    'surname -> Georgiev',
    'age -> 20',
    'grade -> 6.00',
    'date -> 23/05/1995',
    'town -> Sofia'
]);