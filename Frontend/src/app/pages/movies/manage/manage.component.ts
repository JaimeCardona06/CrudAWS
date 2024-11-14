import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Movie } from 'src/app/models/movie.model';
import { MovieService } from 'src/app/services/movie.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage',
  templateUrl: './manage.component.html',
  styleUrls: ['./manage.component.scss']
})
export class ManageComponent implements OnInit {

  mode:number; //1->View, 2->Create, 3->Update 
  movie:Movie;
  theFormGroup: FormGroup;
  trySend:boolean;

  constructor(private activateRoute: ActivatedRoute, 
    private service:MovieService,
    private router:Router,
    private theFormBuilder:FormBuilder) { 
      this.trySend = false;
      this.mode = 1;
      this.movie={
        name: "",
        duration: 0,
        revenue: 0,
        release_date: ""
      }

      this.configFormGroup();
    }

    configFormGroup(){
      this.theFormGroup = this.theFormBuilder.group({
        //Primer elemento del vector, valor por defecto
        //Lista seran las reglas
        name: ['', [Validators.required]],
        duration: [0, [Validators.required]],
        revenue: [0, [Validators.required]],
        release_date: ['', [Validators.required]]
      });
    }
  
    get getTheFormGroup(){
      return this.theFormGroup.controls;
    }

    ngOnInit(): void {
      const currentUrl = this.activateRoute.snapshot.url.join("/");
  
      if(currentUrl.includes('view')){
        this.mode = 1;
      }else if(currentUrl.includes('create')){
        this.mode = 2;
      }else if(currentUrl.includes('update')){
        this.mode = 3;
      }
      
      if(this.activateRoute.snapshot.params.id){
        this.movie.id = this.activateRoute.snapshot.params.id;
        this.getMovie(this.movie.id); 
      }
    }

    getMovie(id:string){
      this.service.view(id).subscribe(data=>{
        this.movie = data;
        console.log("Movie: " + JSON.stringify(this.movie))
      })    
    }

    create(){
      if(this.theFormGroup.invalid){
        this.trySend = true;
        Swal.fire("Formulario incompleto.", "Ingrese correctamente los datos solicitados", "error");
        return;
      }
      this.service.create(this.movie).subscribe(data=>{
        Swal.fire("Creación Exitosa", "Se ha creado un nuevo registro", "success");
        this.router.navigate(["movies/list"]);
      });
    }
  
    update(){
      if(this.theFormGroup.invalid){
        this.trySend = true;
        Swal.fire("Formulario incompleto.", "Ingrese correctamente los datos solicitados", "error");
        return;
      }
      this.service.update(this.movie).subscribe(data=>{
        Swal.fire("Actualización Exitosa", "Se ha actualizado un nuevo registro", "success");
        this.router.navigate(["movies/list"]);
      });
    }

}
