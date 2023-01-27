const links = []
async function loadList(x){
    let clubList = []
    await fetch("http://localhost/my_project/phpAPI/listClubs.php")
    .then(function(prm){
        if(prm.status === 500){
            alert(prm.text())
            return false
        }
        else if(prm.status === 200){
            return prm.json()
        }
    })
    .then(function(rep){
        clubList = rep
    })
    .catch(err=>{ console.log("Client error = ",err) })
    .catch(err=>{ console.log("Server error = ",err) })

    console.log("req resolution")
    let lista = "" 
    for(let i = 0; i < clubList.length; i++){
        lista += "<li style='width:100%;display:flex;justify-content:space-around;margin:15px'> <img style='width:50px;height:50px' alt="+clubList[i]['nom']+" src='http://localhost/my_project/phpAPI"+clubList[i]['logo']+"' />"+clubList[i]['nom']+"("+clubList[i]['ville']+") <button class='boutton' id='boutton_"+clubList[i]['id']+"'> Supprimer </button></li>"
    }
    document.querySelector("#liste").innerHTML = lista
}

console.log("loadList")
async function deletes(){
    await loadList()
    let bouttons = document.querySelectorAll(".boutton").forEach(elm=>{
        elm.addEventListener('click',function(event){
            let idClub = event.target.id.split('_')[1]
            fetch("http://localhost/my_project/phpAPI/deleteClub.php?id="+idClub)
            .then(function(prm){
                if(prm.status === 202){
                    alert("Club bien supprimé")
                }
                else{
                    alert("Echéc de la suppression !")
                }
            }).catch(err=>alert("Erreur "+err))
        })
    })
    /*console.log("bouttons = ",bouttons)
    for(let j=0; j < bouttons.length; j++){
        console.log(boutton[j])
        bouttons[j].addEventListener('click',function(event){
            let idClub = event.target.id
            fetch("http://localhost:8080/ige42/arch_rep/phpAPI/deleteClub.php?id="+idClub)
            .then(function(prm){
                if(prm.status === 202){
                    alert("Club bien supprimé")
                }
                else{
                    alert("Echéc de la suppression !")
                }
            }).catch(err=>alert("Erreur "+err))
        })
    } */
}
deletes()
