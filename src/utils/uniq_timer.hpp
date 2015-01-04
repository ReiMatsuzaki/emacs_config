// * Begin          
// ** ifndef

#ifndef TIMER_HPP
#define TIMER_HPP


// ** include

#include <map>
#include <time.h>


// ** using

using std::map;
using std::string;
using std::cout;
using std::endl;


// * Class          
// ** start

class UniqueTimer {
  
// ** Status enum

  enum class Status {
    None,
    Start,
    End,
  };
  
  
// ** Data strut

  struct TimeData {
    int id;
    clock_t t0;
    clock_t t1;
    Status status;
  };


// ** Field

private:
  int current_id;
  map<string, TimeData> label_data_list;

  
// ** Constructor

public:
  UniqueTimer() :
    current_id(0) {}
  

// * Accessor       
// ** Reset

public:
  void Reset() {
    
    label_data_list.clear();
    
  }


// ** Get Status


public:
  Status GetStatus(string label) {

    Status status =
      (label_data_list.find(label) == 
       label_data_list.end()) ?
      Status::None :
      label_data_list[label].status;
    return status;
  }


// ** Start timer

public:
  void Start(string label) {

    if(GetStatus(label) != Status::None) {
      string msg = "In UniqueTimer::Start, ";
      msg += label + " is already started or ended.";
      throw std::runtime_error(msg);
    }

    TimeData data;
    data.id = current_id;
    ++current_id;
    data.t0 = clock();
    data.status = Status::Start;    

    label_data_list.insert(make_pair(label, data));

  }

  
// ** End Timer

public:
  void End(string label) {

    if(GetStatus(label) == Status::None) {
      string msg = "In UniqueTimer::End, ";
      msg += label + " is not started.";
      throw std::runtime_error(msg);
    }
    if(GetStatus(label) == Status::End) {
      string msg = "In UniqueTimer::End, ";
      msg += label  + " is already ended.";
      throw std::runtime_error(msg);
    }

    label_data_list[label].t1 = clock();
    label_data_list[label].status = Status::End;

  }

  
// * IO             
// ** display

public:
  void Display() {

    cout << "label : time / s" << endl;
    
    for(auto label_data : label_data_list) {

      string   label = label_data.first;
      TimeData data  = label_data.second;

      if(GetStatus(label) != Status::End) {
	string msg = "In UniqueTimer::Display, ";
	msg += label + " is not ended.";
	throw std::runtime_error(msg);
      }

      double dt = (1.0*(data.t1 - data.t0)) / CLOCKS_PER_SEC;
      cout << label << " : " << dt << endl;
    }
  }
  
  
// * End            
};
#endif



