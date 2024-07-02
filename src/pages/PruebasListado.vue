<template>
  <q-page class="bg-positive">
    <div class="q-pa-md q-gutter-sm"></div>
    <h2>Login</h2>
    <q-input filled v-model="inputemail" type="email" hint="Email" />
    <q-input filled v-model="inputpassword" type="password" label="Password" />
    <q-btn label="Login" @click="login" color="primary" />
    <h2>Listado de Notas</h2>
    <p v-for="note in notes" :key="note.id">
      {{ note.note }}
    </p>
    <q-btn label="Ver notas" @click="verNotas" color="primary" />
  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { supabase } from "boot/supabase.js";

//const store = useCounterStore();
//const router = useRouter();
const inputemail = ref("info@blogruben.com");
const inputpassword = ref(null);
const notes = ref([]);

async function login() {
  try {
    const { data, error } = await supabase.auth.signInWithPassword({
      email: inputemail.value,
      password: inputpassword.value,
    });
    inputpassword.value = null;
    if (error) throw error;
    console.log("Logueado con contrasena.");
  } catch (error) {
    alert(error);
  }
}

async function verNotas() {
  try {
    let { data: simple_tags, error } = await supabase.from("tags").select(`id,
               name,
               tags ( id, name )
                 `);
    if (error) throw error;
    //notes.value = simple_tags;
    console.log(simple_tags);
  } catch (error) {
    alert(error);
  }
}
</script>
