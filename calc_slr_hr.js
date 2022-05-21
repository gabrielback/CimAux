

const totalHoraExtra = (valorHora, qntHoras50PorCento, qntHoras100Porcento) => {
    qntHoras50PorCento *= valorHora*1.5
    qntHoras100Porcento *= valorHora*2
    return `50% => R$${qntHoras50PorCento}\n100% => R$${qntHoras100Porcento}\nTotal => ${qntHoras50PorCento+qntHoras100Porcento}`
}


console.log(totalHoraExtra(22,(12),0))
