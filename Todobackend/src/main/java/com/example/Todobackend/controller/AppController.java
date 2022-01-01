package com.example.Todobackend.controller;


import com.example.Todobackend.entity.Task;
import com.example.Todobackend.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/api")
public class AppController {

    @Autowired
    private TaskRepository repo;

    @GetMapping("")
    public List<Task> getTask(){

        return repo.findAll();

    }


    @PostMapping("/add")
    public Task addTask(@RequestBody @Valid Task task){

        return repo.save(task);

    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateTask(@PathVariable Long id){

        boolean exist = repo.existsById(id);

        if(exist){

            Task taskitem = repo.getById(id);
            boolean done = taskitem.isCompleted();
            taskitem.setCompleted(!done);
            repo.save(taskitem);

            return new ResponseEntity<>("Task updated", HttpStatus.OK);

        }

        return new ResponseEntity<>("Task id not found", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteTask(@PathVariable Long id){

        boolean exist = repo.existsById(id);

        if(exist){

            repo.deleteById(id);
            return new ResponseEntity<>("Task deleted Successfully", HttpStatus.OK);

        }

        return new ResponseEntity<>("Task id not found", HttpStatus.BAD_REQUEST);

    }

}
