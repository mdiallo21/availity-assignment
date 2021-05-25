import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';

import { IRegistration } from  '../../model/registration';
import { RegistrationService } from '../../services/registration.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  registrationForm = this.formBuilder.group({
    firstName: ['', Validators.required],
    lastName: ['', Validators.required],
    npiNumber: ['', Validators.required],
    telephone: ['', [Validators.required, Validators.minLength(10)]],
    email: ['', [Validators.required, Validators.email]],
    address: ['', Validators.required],
    address2: [''],
    city: ['', Validators.required],
    state: ['', Validators.required],
    zip: ['', Validators.required],
  })

  constructor(private formBuilder: FormBuilder, private registrationService: RegistrationService, private router: Router) { }

  ngOnInit(): void {
  }
  onSubmit(){
    if(this.registrationForm.valid && !this.registrationForm.untouched){
      const registrationObject : IRegistration = {
        firstName: this.registrationForm.controls['firstName'].value,
        lastName: this.registrationForm.controls['lastName'].value,
        npiNumber: this.registrationForm.controls['npiNumber'].value,
        telephone: this.registrationForm.controls['telephone'].value,
        email: this.registrationForm.controls['email'].value,
        address: this.registrationForm.controls['address'].value,
        addres2: this.registrationForm.controls['address2'].value,
        city: this.registrationForm.controls['city'].value,
        state: this.registrationForm.controls['state'].value,
        zip: this.registrationForm.controls['zip'].value
       }

       this.registrationService.sendRegistrationData(registrationObject);
       this.router.navigate(['confirm']);
      }
    }
}
