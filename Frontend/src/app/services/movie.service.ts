import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Movie } from '../models/movie.model';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class MovieService {

  constructor(private http: HttpClient) { }

  list(): Observable<Movie[]> {
    return this.http.get<Movie[]>(`${environment.url}/movies`);
  }
  view(id:string):Observable<Movie>{
    return this.http.get<Movie>(`${environment.url}/movies/${id}`);
  }
  create(theMovie:Movie):Observable<Movie>{
    return this.http.post<Movie>(`${environment.url}/movies`, theMovie);
  }
  update(theMovie:Movie):Observable<Movie>{
    return this.http.put<Movie>(`${environment.url}/movies/${theMovie.id}`, theMovie);
  }
  delete(id:number){
    return this.http.delete<Movie>(`${environment.url}/movies/${id}`);
  }
}
