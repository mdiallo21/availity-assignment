import { BehaviorSubject, Observable } from 'rxjs';

import { IRegistration } from '../model/registration'
import { Injectable } from '@angular/core';
import { registrationData } from '../model/registrationData';

@Injectable({
  providedIn: 'root'
})
export class RegistrationService {
  readonly registrationData$ = new BehaviorSubject<IRegistration>(registrationData);

  constructor() { }

  sendRegistrationData(registrationData: IRegistration){
    this.registrationData$.next(registrationData);
  }

  receiveRegistrationData(): Observable<IRegistration>{
    return this.registrationData$.asObservable();
  }
}
