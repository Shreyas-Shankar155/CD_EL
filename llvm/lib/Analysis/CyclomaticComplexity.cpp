//=============================================================================
// FILE:
//    HelloWorld.cpp
//
// DESCRIPTION:
//    Visits all functions in a module, prints their names and the number of
//    arguments via stderr. Strictly speaking, this is an analysis pass (i.e.
//    the functions are not modified). However, in order to keep things simple
//    there's no 'print' method here (every analysis pass should implement it).
//
// USAGE:
//    New PM
//      opt -load-pass-plugin=libHelloWorld.dylib -passes="hello-world" `\`
//        -disable-output <input-llvm-file>
//
//
// License: MIT
//=============================================================================
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/CommandLine.h"
#include <string>
#include <cstdio>

#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include "llvm/InitializePasses.h"
#include "llvm/CodeGen/Passes.h"

namespace llvm{
static cl::opt<bool> EnableCyclomatic("analyze-Cyclomatic", cl::init(false), cl::Hidden);
}

int flag = 1;
//static cl::opt<std::string> InputFile("input", cl::desc("Specify input file"));
//-----------------------------------------------------------------------------
// HelloWorld implementation
//-----------------------------------------------------------------------------
// No need to expose the internals of the pass to the outside world - keep
// everything in an anonymous namespace.

using namespace llvm;
namespace{

//counts number of ifs and loops (while/do-while/for have if statements in their construct)
int countIF(Function &F){ 
      int ifCount = 0;
      for (auto &BB : F) {      // Iterate over each basic block in the function
        for (auto &I : BB) {        // Iterate over each instruction in the basic block
          if (auto *BI = dyn_cast<BranchInst>(&I)) { // Check if the instruction is a BranchInst and conditional
            if (BI->isConditional()) {
              ifCount++;
              }
            }
          }
        }
	return ifCount;
}

int countSwitchCase(Function &F){
	int Count = 0;
	for (auto &BB : F) {
                for (auto &I : BB) {
                    if (auto *SI = dyn_cast<SwitchInst>(&I)) {
                        Count += SI->getNumCases(); //getNumCases() finds number of case labels
                    }
                }
            }
	return Count;
}
// This method implements what the pass does
void visitor(Function &F, raw_ostream &Out) {
   int ifCount = countIF(F);   
   int SwitchCount = countSwitchCase(F);
   int res = ifCount + SwitchCount + 1; 
	Out << F.getName() << ":" << res << "\n";
    outs() << "Function name: "<< F.getName() << "\n";
    outs() << "No. of args: " << F.arg_size() << "\n";
	outs() << "Number of ifs: " << ifCount << "\n";

}

class CyclomaticAnalyzer : public FunctionPass {
    public: 	
	    static char ID;

    	CyclomaticAnalyzer() : FunctionPass(ID) //{}
		{llvm::initializeCyclomaticAnalyzerPass(*PassRegistry::getPassRegistry());}

    bool runOnFunction(Function &F) override { 
    //logic here
    	if(!llvm::EnableCyclomatic){
    		return false; //return if arg not passed
    	}
	const char* filename = "output.txt";
	if(flag==1){
		flag = 0;
		if(remove(filename)==0){
			outs() << "Error deleting file " << filename <<"\n";
		}
		}
	    std::error_code EC;
	    raw_fd_ostream Out(filename, EC, llvm::sys::fs::OF_Append);
    
	    if (EC) {
	      errs() << "Could not open output file: " << EC.message() << "\n";
	      return false;
	      }
	    visitor(F, Out);
        return false;
    }
};
}

/*
CyclomaticAnalyzer::CyclomaticAnalyzer() : FunctionPass(ID){
	llvm::initializeCyclomaticAnalyzerPass(*PassRegistry::getPassRegistry());
}
*/

char CyclomaticAnalyzer::ID = 0;

INITIALIZE_PASS_BEGIN(CyclomaticAnalyzer, "CyclomaticAnalyzer", " Prints Cyclomatic Complexity per function",
                                             false ,// Only looks at CFG 
                                                                          false ) //false for analysis pass
// Add pass dependencies here:
//INITIALIZE_PASS_DEPENDENCY(CyclomaticAnalyzer)

INITIALIZE_PASS_END(CyclomaticAnalyzer, "CyclomaticAnalyzer", " Prints Cyclomatic Complexity per function",
                    false , false)

//using namespace llvm;
FunctionPass *llvm::createCyclomaticAnalyzerPass() 
	{return new CyclomaticAnalyzer(); }

/*
struct HelloWorld  : PassInfoMixin<HelloWorld> {
  // Main entry point, takes IR unit to run the pass on (&F) and the
  // corresponding pass manager (to be queried if need be)
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {

//	 std::string filename = InputFile;
//        outs() << "Filename:" << filename << "\n";
	const char* filename = "output.txt";
	if(flag==1){
		flag = 0;
		if(remove(filename)==0){
			outs() << "Error deleting file " << filename <<"\n";
		}
		}
	    std::error_code EC;
	    raw_fd_ostream Out(filename, EC, llvm::sys::fs::OF_Append);
    
	    if (EC) {
	      errs() << "Could not open output file: " << EC.message() << "\n";
	      return PreservedAnalyses::all();
	      }
    visitor(F, Out);
    return PreservedAnalyses::all();  }

  // Without isRequired returning true, this pass will be skipped for functions
  // decorated with the optnone LLVM attribute. Note that clang -O0 decorates
  // all functions with optnone.
  static bool isRequired() { return true; }
};
} // namespace
*/

// Automatically enable the pass.

/*
static void registerPass(const PassManagerBuilder &,
                         legacy::PassManagerBase &PM) {
  PM.add(new HelloWorld());
}
static RegisterStandardPasses
  RegisterMyPass(PassManagerBuilder::EP_EarlyAsPossible,
                 registerPass);
*/

               
/*
//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getHelloWorldPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HelloWorld", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "hello-world") {
                  
                    FPM.addPass(HelloWorld());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize HelloWorld when added to the pass pipeline on the
// command line, i.e. via '-passes=hello-world'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getHelloWorldPluginInfo();
}
*/
