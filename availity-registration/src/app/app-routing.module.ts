import { RouterModule, Routes } from '@angular/router';

import { NgModule } from '@angular/core';
import { PageNotFoundComponent } from './page-not-found.component';
import { RegisterComponent } from './registration/register/register.component';
import { RegistrationConfirmComponent } from './registration-confirm/registration-confirm.component';

const routes: Routes = [
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'home', component: RegisterComponent },
  { path: 'confirm', component: RegistrationConfirmComponent},
  { path: '**', component: PageNotFoundComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
