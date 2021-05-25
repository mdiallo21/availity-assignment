import { Component, OnInit } from '@angular/core';

import { IRegistration } from  '../model/registration';
import { Observable } from 'rxjs';
import { RegistrationService } from '../services/registration.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-registration-confirm',
  templateUrl: './registration-confirm.component.html',
  styleUrls: ['./registration-confirm.component.css']
})
export class RegistrationConfirmComponent implements OnInit {

  registrationConfirmation$: Observable<IRegistration>;
  constructor(private registrationService: RegistrationService, private router: Router) { }

  ngOnInit(): void {
    this.registrationConfirmation$ = this.registrationService.receiveRegistrationData();
  }
  goBack(){
    this.router.navigate(['home']);
  }

}
